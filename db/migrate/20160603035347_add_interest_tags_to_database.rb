#encoding:utf-8
class AddInterestTagsToDatabase < ActiveRecord::Migration
  def change

    tags = ['Arquitetura', 'Artes', 'Ciência', 'Tecnologia', 'Cinema', 'Vídeo', 'Design', 'Moda',
            'Educação', 'Esporte', 'Fotografia', 'Gastronomia', 'Música', 'Literatura', 'Teatro',
            'Dança', 'Empreendedorismo', 'Permacultura']
    tags.each do |tag|
      ActsAsTaggableOn::Tag.new(:name => tag).save
    end

  end
end
