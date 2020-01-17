# Elixir elevator driver

[Documetnation](https://jornbh.github.io/heis_driver/doc/index.html)


If you are using Mix as you Elixir build tool (which you really should), go into mix.exs and modify the function `deps` to contain

```[elixir]
defp deps do
    [
      {:heis_driver, git: "https://github.com/jornbh/heis_driver.git", tag: "0.1.0"}
    ]
  end
```

Modify the tag to correspond to a newer release if some bugfixes are added later.

The driver should be available as a module named `Driver`, just like your normal modules.

## Usage

You must start the driver with `start_link()` or `start_link(ip_address, port)` before any of the other functions will work. The user is responsible for not giving stupid input or polling nonexistent buttons.

## API

### Functions

```[elixir]
{:ok, driver_pid} = Driver.start_link
  button_pressed?(floor, button_direction)
  set_motor_dir(motor_direction)
  set_button_light(floor, button_direction, on_or_off)
  set_floor_indicator(floor)
  set_door_state(door_state)
```

### Data-types

door_state: (:opne/:closed) motor_direction: (:hall_up/:hall_down/:cab) floor: (0/1/.../number_of_floors -1) door_state: :open/:closed

## Using the driver in Erlang

If you are using rebar3, downloading the dependency is somewhat similar, but you need a plugin. Just add/modify the lines for `plugins` and `provider_hooks` in rebar.config, so that they look like this

```
{plugins, [rebar_mix]}.
{provider_hooks, [{post, [{compile, {mix, consolidate_protocols}}]}]}.
```

This makes it possible to include elixir-dependencies. Afterwards, modify the line for `deps`, so that it becomes:

```[erlang]
{deps, [
    {heis_driver, {git, "git://github.com/jornbh/heis_driver.git", {tag, "0.1.0"}}}
]}.
```

Now, you will have to write call the module, which will be an atom that starts With "Elixir.", and the rest is just the normal module name. If the function has problematic signs, use the same type of quotes around it as well.

```
'Elixir.Driver':set_door_state(closed). 
'Elixir.Driver':'button_pressed?'(1, hall_up).
```

## Further reading

GenServers are a really neat way to make servers without having to rewrite the same code all the time. It works _Exactly_ the same in Erlang as well, but it is called gen_server instead. The erlang documentation is kind of difficult to understand, so use the elixir-video and "Translate" it to Erlang (gen_server:call(...) instead of GenServer.call(...)).

The short version is that a GenServer implements the basic parts of a server, and the code that is seen in this file is the "Blanks" you have to fill in

### A youtube-video that explains GenServers and Supervisors

<https://www.youtube.com/watch?v=3EjRvaCOl94>
