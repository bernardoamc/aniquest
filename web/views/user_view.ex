defmodule Aniquest.UserView do
  use Aniquest.Web, :view

  def format_time(time) do
    if time do
      {:ok, valid_until} = Timex.format(time, "%Y-%m-%d %M:%S", :strftime)
      valid_until
    else
      "-"
    end
  end
end
