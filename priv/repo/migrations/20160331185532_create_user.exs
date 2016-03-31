defmodule Aniquest.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :picture, :string
      add :token, :string
      add :token_valid_until, :datetime

      timestamps
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:token])
  end
end
