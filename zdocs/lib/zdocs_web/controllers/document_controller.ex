defmodule ZdocsWeb.DocumentController do
  use ZdocsWeb, :controller

  alias Zdocs.Publications
  alias Zdocs.Publications.Document

  def index(conn, _params) do
    docs = Publications.list_docs()
    render(conn, :index, docs: docs)
  end

  def new(conn, _params) do
    changeset = Publications.change_document(%Document{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"document" => document_params}) do
    case Publications.create_document(document_params) do
      {:ok, document} ->
        conn
        |> put_flash(:info, "Document created successfully.")
        |> redirect(to: ~p"/docs/#{document}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Publications.get_document!(id)
    render(conn, :show, document: document)
  end

  def edit(conn, %{"id" => id}) do
    document = Publications.get_document!(id)
    changeset = Publications.change_document(document)
    render(conn, :edit, document: document, changeset: changeset)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Publications.get_document!(id)

    case Publications.update_document(document, document_params) do
      {:ok, document} ->
        conn
        |> put_flash(:info, "Document updated successfully.")
        |> redirect(to: ~p"/docs/#{document}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, document: document, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Publications.get_document!(id)
    {:ok, _document} = Publications.delete_document(document)

    conn
    |> put_flash(:info, "Document deleted successfully.")
    |> redirect(to: ~p"/docs")
  end
end
