#encoding:utf-8
module Reports
  module Financial
    class Monthly
      class << self
        def report(month, year)
          date = Date.new(year.to_i, month.to_i) + 1.second
          @projects = Project.where('expires_at > ? AND expires_at < ?', date, date + 1.month).order('expires_at ASC')

          @csv = CSV.generate(:col_sep => ',') do |csv_string|

             csv_header = [
              'Nome do Encontro',
              'ID do Encontro',
              'Data do Encontro',
              'Data do fechamento das inscrições',
              'Publicado',
              'Confirmado',
              'Deadline de Pagamento',
              'ID Moip do organizador',
              'Arrecadação Total',
              'Taxa do Moip',
              'Taxa Nos.vc',
              'Valor sem Taxa',
              'Organizador',
              'E-mail Organizador',
              'Cidade',
              'Pago'
            ]

            csv_string << csv_header

            @projects.each do |project|
              backer_count = project.backers.confirmed.count
              backer_mean = backer_count == 0 ? 0 : project.pledged / backer_count

              csv_line = [
                project.name,
                project.id,
                project.when_short,
                I18n.l(project.expires_at),
                project.visible ? I18n.t('yes') : I18n.t('no'),
                project.successful ? I18n.t('yes') : I18n.t('no'),
                nil,
                project.user.payment_email,
                project.pledged,
                project.total_payment_method_fee,
                project.expected_fee,
                project.expected_revenue,
                project.user.name,
                project.user.email,
                project.category.name,
                nil
              ]

              csv_string << csv_line
            end
          end
        end
      end
    end
  end
end