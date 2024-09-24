defmodule Zdocs.PublicationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Zdocs.Publications` context.
  """

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{
        description: "some description",
        locator: "some locator",
        public: true,
        source: "some source",
        title: "some title"
      })
      |> Zdocs.Publications.create_document()

    document
  end
end
