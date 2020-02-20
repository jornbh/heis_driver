defmodule HeisDriverTest do
  use ExUnit.Case
  @doctest "Just run all the valid function calls and see if it crashes"
  test "Test_function_calls" do
    {:ok, _driver_pid} = Driver.start_link
    # Stupid test because it is easy
    Driver.poll_floor_sensor
    for floor <- 0..3,
      motor_direction <- [:up, :down, :still],
      button_direction <-[:hall_up, :hall_down, :cab],
      on_or_off <- [:on, :off],
      door_state <-[:open, :closed],
      not (floor==3 and button_direction ==:hall_up),
      not (floor==3 and button_direction ==:hall_up) do
        Driver.button_pressed?(floor, button_direction)
        Driver.set_motor_dir(motor_direction)
        Driver.set_button_light(floor, button_direction, on_or_off)
        Driver.set_floor_indicator(floor)
        Driver.set_door_state(door_state)
    end
  end
  @doctest "Run once up, and then down, to test the motors"
  test "Demo-program" do
    {:ok, _driver_pid} = Driver.start_link()
    :ok = Driver.set_motor_dir( :motor_up)

    poll_loop_until_floor(3)

    :ok = Driver.set_motor_dir( :motor_down)
    poll_loop_until_floor(0)
    :ok = Driver.set_motor_dir( :stop)

  end
  def poll_loop_until_floor(dest) do
    state = Driver.poll_floor_sensor()
    if state != :between_floors do
      Driver.set_floor_indicator(state)
    end
    case state do
      ^dest -> :ok
      _ ->
        :timer.sleep(100)
        poll_loop_until_floor(dest)
    end
  end
end
