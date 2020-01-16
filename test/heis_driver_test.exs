defmodule HeisDriverTest do
  use ExUnit.Case
  # @doctest HeisDriver "Just run all the valid function calls and see if it crashes"

  test "Test_function_calls" do
  # {:ok, driver_pid} = Driver.start_link
  # for motor_direction <- [:up, :down, :stop],
  #     floor <- 0..3,
  #     on_or_off <- [:on, :off],
  #     button_direction <- [:hall_up, :hall_down, :cab],
  #     not ( floor == 3 and button_direction == :hall_up ),
  #     not ( floor == 1 and button_direction == :hall_down ) do
  #       Driver.set_motor_direction( driver_pid, motor_direction  )
  #       Driver.set_motor_direction( driver_pid, :stop )
  #       Driver.set_order_button_light( driver_pid, button_direction ,floor, on_or_off   )
  #       Driver.set_floor_indicator( driver_pid, floor )
  #       Driver.set_stop_button_light( driver_pid, on_or_off )
  #       Driver.set_door_open_light( driver_pid, on_or_off )
  #       Driver.get_order_button_state( driver_pid,floor, button_direction   )
  #       Driver.get_floor_sensor_state( driver_pid )
  #       Driver.get_stop_button_state( driver_pid )
  #       Driver.get_obstruction_switch_state( driver_pid )
  #   end

    {:ok, _driver_pid} = Driver.start_link
    # Stupid test because it is easy
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
end
