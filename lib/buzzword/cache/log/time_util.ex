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
  Converts `durations` ([h, min, s, ms]) and `units` into a formatted string.

  ## Options

    * `:units` - list of strings to use as units. Defaults to
      `[" h", " min", " s", " ms"]`.

    * `:show_zeroes` - whether to show zero values. Defaults to `false`.

    * `:two_digits` - whether to pad single-digit values with a leading zero.
      Defaults to `false`.

  ## Examples

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1])
      "1 h 1 min 6 s 1 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], units: [:hr, :min, :sec])
      "1hr 1min 6sec"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], units: [" hour(s)", " minute(s)"])
      "1 hour(s) 1 minute(s)"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], units: [" H", " MIN", " S"])
      "1 H 1 MIN 6 S"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 6, 1], units: ["H", "MIN", "S", "MS"])
      "1H 1MIN 6S 1MS"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 0, 1])
      "1 h 1 min 1 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 0, 1], show_zeroes: true)
      "1 h 1 min 0 s 1 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 0, 1], show_zeroes: true, two_digits: true)
      "01 h 01 min 00 s 01 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> options = [show_zeroes: true, two_digits: true]
      iex> TimeUtil.format([1234, 1, 0, 199], options)
      "1234 h 01 min 00 s 199 ms"

      iex> alias Buzzword.Cache.Log.TimeUtil
      iex> TimeUtil.format([1, 1, 0, 1], two_digits: true)
      "01 h 01 min 01 ms"
  """
  @spec format([non_neg_integer], keyword) :: String.t()
  def format(durations, options \\ [])
      when is_list(durations) and is_list(options) do
    units = Keyword.get(options, :units, [" h", " min", " s", " ms"])
    show_zeroes = Keyword.get(options, :show_zeroes, false)
    min_length = if Keyword.get(options, :two_digits, false), do: 2, else: 1

    for {duration, unit} <- Enum.zip(durations, units),
        show_zeroes or duration > 0,
        duration = String.pad_leading("#{duration}", min_length, "0"),
        reduce: "" do
      "" -> "#{duration}#{unit}"
      acc -> acc <> " #{duration}#{unit}"
    end
  end
end
