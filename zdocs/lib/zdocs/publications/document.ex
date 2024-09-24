defmodule Zdocs.Publications.Document do
  use Ecto.Schema
  import Ecto.Changeset

  schema "docs" do
    field :public, :boolean, default: false
    field :description, :string
    field :title, :string
    field :source, :string
    field :locator, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(document, attrs) do
    document
    |> cast(attrs, [:title, :description, :public, :locator, :source])
    |> validate_required([:title, :description, :public, :locator, :source])
  end
end
