#encoding:utf-8
module Reports
  module Users
    class Attendance
      class << self
        def report(project_id)
          @backers = Project.find(project_id).backers.confirmed

          @csv = CSV.generate(:col_sep => ',') do |csv_string|

            csv_header = [
              'Nome',
              'Valor da Inscrição',
              'Presente'
            ]

            csv_string << csv_header

            @backers.each do |backer|

              csv_line = [
                backer.user.name,
                "#{backer.reward.description} (#{backer.display_value})",
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