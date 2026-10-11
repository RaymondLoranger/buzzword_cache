defmodule Buzzword.Cache.Log.TimeUtil do
  @moduledoc """
  Utility functions for logging time-related information.
  """

  @ms_in_h 3_600_000
  @ms_in_m 60_000
  @ms_in_s 1_000

  @doc """
  Splits milliseconds into [hours, minutes, seconds, milliseconds].

  ## Examples

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.split(3_666_001)
      [1, 1, 6, 1]

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.split(3_660_001)
      [1, 1, 0, 1]

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.split(3_606_001)
      [1, 0, 6, 1]
  """
  @spec split(non_neg_integer) :: [non_neg_integer]
  def split(ms) when is_integer(ms) and ms > 0 do
    [
      div(ms, @ms_in_h),
      rem(ms, @ms_in_h) |> div(@ms_in_m),
      rem(ms, @ms_in_m) |> div(@ms_in_s),
      rem(ms, @ms_in_s)
    ]
  end

  @doc """
  Converts `duration_split` and `units` into a formatted string.

  ## Examples

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1])
      "1 h 1 min 6 s 1 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], [:hr, :min, :sec])
      "1 hr 1 min 6 sec"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], ["hour(s)", "minute(s)"])
      "1 hour(s) 1 minute(s)"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 0, 1])
      "1 h 1 min 1 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 0, 6, 1])
      "1 h 6 s 1 ms"
  """
  @spec format([non_neg_integer], [atom | String.t()]) :: String.t()
  def format(duration_split, units \\ [:h, :min, :s, :ms])
      when is_list(duration_split) and is_list(units) do
    for {v, u} <- Enum.zip(duration_split, units), v > 0, reduce: "" do
      "" -> "#{v} #{u}"
      acc -> acc <> " #{v} #{u}"
    end
  end
end
