defmodule SeptaGongWeb.ChannelsController do
  use SeptaGongWeb, :controller


  def index(conn, _params) do
    # users = Redirect.list_users()
    # render(conn, "index.html", users: users)
    channel_id = random_string(8)

    conn
    |> redirect(to: Routes.gong_path(conn, :index, channel_id))

  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
