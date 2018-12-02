use Mix.Config

config :buzzword_cache,
  course_ref:
    """
    Based on the course [Multi-Player Bingo]
    (https://pragmaticstudio.com/courses/unpacked-bingo)\s
    by Mike and Nicole Clark.
    """
    |> String.replace("\n", "")
