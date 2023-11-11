defmodule PhxClusterWeb.PageController do
  use PhxClusterWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
