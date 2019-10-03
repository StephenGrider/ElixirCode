defmodule Reddit.Repo.Migrations.Comments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string
      add :user_id, references(:users)
      add :post_id, references(:posts)

      timestamps
    end
  end
end
