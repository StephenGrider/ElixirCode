defmodule Reddit.Repo.Migrations.AddPosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :user_id, references(:users)

      timestamps
    end
  end
end
