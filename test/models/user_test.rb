require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    Timecop.freeze(202, 10, 5, 3)
    @user = User.create username: "test", password: "123456", last_refreshed: 4.hours.ago
  end

  test "test should reopen task" do
    @user.tasks << Task.create(title: "test titel 1", completed_at: 5.hour.ago, repeat_after: 1)
    @user.tasks << Task.create(title: "test titel 2", completed_at: 4.hour.ago, repeat_after: 1)
    @user.tasks << Task.create(title: "test titel 3", completed_at: 3.hour.ago, repeat_after: 1)

    run_reopen

    assert_equal 1, Task.completed.count
    assert_equal 2, Task.uncompleted.count
  end

  test "test should not reopen task" do
    @user.tasks << Task.create(title: "test titel 1", completed_at: 5.hour.ago, repeat_after: 0)
    @user.tasks << Task.create(title: "test titel 2", completed_at: 4.hour.ago)
    @user.tasks << Task.create(title: "test titel 3", completed_at: 3.hour.ago)

    run_reopen

    assert_equal 3, Task.completed.count
    assert_equal 0, Task.uncompleted.count
  end

  def run_reopen
    if @user.refreshable?
      @user.tasks.completed.repeatable.each do |task|
        task.reopen
      end
    end
  end
end
