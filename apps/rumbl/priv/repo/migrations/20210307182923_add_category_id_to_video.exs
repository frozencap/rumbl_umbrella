defmodule Rumbl.Repo.Migrations.AddCategoryIdToVideo do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      # on category delete, video.category_id = null
      add :category_id, references(:categories, on_delete: :nilify_all)
    end
  end
end
