#Migration to add director column to movies table.
class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :director, :string
  end
end
