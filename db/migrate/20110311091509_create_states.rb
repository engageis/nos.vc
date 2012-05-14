# coding: utf-8
require 'sexy_pg_constraints'
class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name, :null => false
      t.string :acronym, :null => false
      t.timestamps
    end
    constrain :states do |t|
      t.name :not_blank => true, :unique => true
      t.acronym :not_blank => true, :unique => true
    end
    execute "INSERT INTO states (name, acronym, created_at, updated_at) VALUES
      ('Acre', 'AC', now(), now()),
      ('Alagoas', 'AL', now(), now()),
      ('Amapá', 'AP', now(), now()),
      ('Amazonas', 'AM', now(), now()),
      ('Bahia', 'BA', now(), now()),
      ('Ceará', 'CE', now(), now()),
      ('Distrito Federal', 'DF', now(), now()),
      ('Espírito Santo', 'ES', now(), now()),
      ('Goiás', 'GO', now(), now()),
      ('Maranhão', 'MA', now(), now()),
      ('Mato Grosso', 'MT', now(), now()),
      ('Mato Grosso do Sul', 'MS', now(), now()),
      ('Minas Gerais', 'MG', now(), now()),
      ('Pará', 'PA', now(), now()),
      ('Paraíba', 'PB', now(), now()),
      ('Paraná', 'PR', now(), now()),
      ('Pernambuco', 'PE', now(), now()),
      ('Piauí', 'PI', now(), now()),
      ('Rio de Janeiro', 'RJ', now(), now()),
      ('Rio Grande do Norte', 'RN', now(), now()),
      ('Rio Grande do Sul', 'RS', now(), now()),
      ('Rondônia', 'RO', now(), now()),
      ('Roraima', 'RR', now(), now()),
      ('Santa Catarina', 'SC', now(), now()),
      ('São Paulo', 'SP', now(), now()),
      ('Sergipe', 'SE', now(), now()),
      ('Tocantins', 'TO', now(), now())"
  end

  def self.down
    drop_table :states
  end
end
