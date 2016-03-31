defmodule Aniquest.Repo.Migrations.CreateAPI.V1.Anime do
  use Ecto.Migration

  def change do
    create table(:animes) do
      add :title_romaji, :string
      add :title_english, :string
      add :genres, {:array, :string}
      add :plot, :string

      timestamps
    end

    create unique_index(:animes, [:title_romaji])
  end
end
