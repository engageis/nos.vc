#encoding:utf-8
module Reports
  module Users
    class Attendance
      class << self
        def report(project_id)
          project = Project.find(project_id)
          @backers = project.backers.confirmed

          @csv = CSV.generate(:col_sep => ',') do |csv_string|

            csv_header = [
              'Nome',
              'Valor da Inscrição',
              'Presente'
            ]

            questions = project.dynamic_fields.pluck(:input_name)
            csv_header.insert(2, questions)
            csv_header.flatten!

            csv_string << csv_header

            @backers.each do |backer|

              csv_line = [
                backer.user.name,
                "#{backer.reward.description} (#{backer.display_value})",
                nil
              ]

              answers = backer.dynamic_values.pluck(:value)
              csv_line.insert(2, answers)
              csv_line.flatten!

              csv_string << csv_line
            end
          end
        end
      end
    end
  end
end