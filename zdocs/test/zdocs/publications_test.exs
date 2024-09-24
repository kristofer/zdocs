defmodule Zdocs.PublicationsTest do
  use Zdocs.DataCase

  alias Zdocs.Publications

  describe "docs" do
    alias Zdocs.Publications.Document

    import Zdocs.PublicationsFixtures

    @invalid_attrs %{public: nil, description: nil, title: nil, source: nil, locator: nil}

    test "list_docs/0 returns all docs" do
      document = document_fixture()
      assert Publications.list_docs() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Publications.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{public: true, description: "some description", title: "some title", source: "some source", locator: "some locator"}

      assert {:ok, %Document{} = document} = Publications.create_document(valid_attrs)
      assert document.public == true
      assert document.description == "some description"
      assert document.title == "some title"
      assert document.source == "some source"
      assert document.locator == "some locator"
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Publications.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{public: false, description: "some updated description", title: "some updated title", source: "some updated source", locator: "some updated locator"}

      assert {:ok, %Document{} = document} = Publications.update_document(document, update_attrs)
      assert document.public == false
      assert document.description == "some updated description"
      assert document.title == "some updated title"
      assert document.source == "some updated source"
      assert document.locator == "some updated locator"
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Publications.update_document(document, @invalid_attrs)
      assert document == Publications.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Publications.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Publications.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Publications.change_document(document)
    end
  end
end
