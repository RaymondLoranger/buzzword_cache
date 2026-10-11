defmodule Buzzword.Cache.Log do
  use File.Only.Logger

  alias __MODULE__.TimeUtil

  warning :line_incorrect, {path, line, line_number, env} do
    """
    \nLine incorrect...
    • File: #{inspect(path) |> maybe_break(8)}
    • Line number: #{line_number}
    • Line: #{inspect(line) |> maybe_break(8)}
    • Correct format:
      "<phrase of 3 or more chars>,<integer points greater than 0>"
    #{from(env, __MODULE__)}\
    """
  end

  info :automatic_refresh, {refresh_interval, env} do
    gone = TimeUtil.split(refresh_interval) |> TimeUtil.format()

    """
    \nBuzzword cache automatically refreshed...
    • Interval: #{inspect(refresh_interval)} ms (#{gone})
    #{from(env, __MODULE__)}\
    """
  end

  info :explicit_refresh, {time_elapsed, time_left, env} do
    gone = TimeUtil.split(time_elapsed) |> TimeUtil.format()
    left = TimeUtil.split(time_left) |> TimeUtil.format()

    """
    \nBuzzword cache explicitly refreshed...
    • Time elapsed: #{inspect(time_elapsed)} ms (#{gone})
    • Time left: #{inspect(time_left)} ms (#{left})
    #{from(env, __MODULE__)}\
    """
  end

  info :reading_buzzwords, {path, env} do
    """
    \nReading CSV file of buzzwords...
    • File: #{inspect(path) |> maybe_break(8)}
    #{from(env, __MODULE__)}\
    """
  end
end
