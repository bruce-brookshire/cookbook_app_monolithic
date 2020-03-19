defmodule CookbookWeb.Api.CookbookController do
  
  use CookbookWeb, :controller

  alias Cookbook.SharedCookbooks
  alias CookbookWeb.SharedCookbookView


  def show(conn, %{"id" => id}) do
    cookbook = SharedCookbooks.get_by_id(id)

    conn 
    |> put_view(SharedCookbookView)
    |> render("show.json", shared_cookbook: cookbook)
  end
  


end