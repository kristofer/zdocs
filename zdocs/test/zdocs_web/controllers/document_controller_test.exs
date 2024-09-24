defmodule ZdocsWeb.DocumentControllerTest do
  use ZdocsWeb.ConnCase

  import Zdocs.PublicationsFixtures

  @create_attrs %{public: true, description: "some description", title: "some title", source: "some source", locator: "some locator"}
  @update_attrs %{public: false, description: "some updated description", title: "some updated title", source: "some updated source", locator: "some updated locator"}
  @invalid_attrs %{public: nil, description: nil, title: nil, source: nil, locator: nil}

  describe "index" do
    test "lists all docs", %{conn: conn} do
      conn = get(conn, ~p"/docs")
      assert html_response(conn, 200) =~ "Listing Docs"
    end
  end

  describe "new document" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/docs/new")
      assert html_response(conn, 200) =~ "New Document"
    end
  end

  describe "create document" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/docs", document: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/docs/#{id}"

      conn = get(conn, ~p"/docs/#{id}")
      assert html_response(conn, 200) =~ "Document #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/docs", document: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Document"
    end
  end

  describe "edit document" do
    setup [:create_document]

    test "renders form for editing chosen document", %{conn: conn, document: document} do
      conn = get(conn, ~p"/docs/#{document}/edit")
      assert html_response(conn, 200) =~ "Edit Document"
    end
  end

  describe "update document" do
    setup [:create_document]

    test "redirects when data is valid", %{conn: conn, document: document} do
      conn = put(conn, ~p"/docs/#{document}", document: @update_attrs)
      assert redirected_to(conn) == ~p"/docs/#{document}"

      conn = get(conn, ~p"/docs/#{document}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, document: document} do
      conn = put(conn, ~p"/docs/#{document}", document: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Document"
    end
  end

  describe "delete document" do
    setup [:create_document]

    test "deletes chosen document", %{conn: conn, document: document} do
      conn = delete(conn, ~p"/docs/#{document}")
      assert redirected_to(conn) == ~p"/docs"

      assert_error_sent 404, fn ->
        get(conn, ~p"/docs/#{document}")
      end
    end
  end

  defp create_document(_) do
    document = document_fixture()
    %{document: document}
  end
end
