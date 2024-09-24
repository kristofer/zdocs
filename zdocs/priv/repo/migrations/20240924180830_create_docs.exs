defmodule Zdocs.Repo.Migrations.CreateDocs do
  use Ecto.Migration

  def change do
    create table(:docs) do
      add :title, :string
      add :description, :string
      add :public, :boolean, default: false, null: false
      add :locator, :string
      add :source, :string

      timestamps(type: :utc_datetime)
    end
  end
end
