defmodule ZdocsWeb.DocumentJSON do
  alias Zdocs.Publications.Document

  @doc """
  Renders a list of docs.
  """
  def index(%{docs: docs}) do
    %{data: for(document <- docs, do: data(document))}
  end

  @doc """
  Renders a single document.
  """
  def show(%{document: document}) do
    %{data: data(document)}
  end

  defp data(%Document{} = document) do
    %{
      id: document.id,
      title: document.title,
      description: document.description,
      public: document.public,
      locator: document.locator,
      source: document.source
    }
  end
end
