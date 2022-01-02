# == Schema Information
#
# Table name: nobels
#
#  yr          :integer
#  subject     :string
#  winner      :string

require_relative './sqlzoo.rb'

def physics_no_chemistry
  # In which years was the Physics prize awarded, but no Chemistry prize?
  execute(<<-SQL)
    SELECT DISTINCT
      physics_nobels.yr
    FROM
      nobels AS physics_nobels
    LEFT OUTER JOIN
      (SELECT yr FROM nobels WHERE subject = 'Chemistry')
        AS chemistry_nobels ON chemistry_nobels.yr = physics_nobels.yr
    WHERE
      (physics_nobels.subject = 'Physics' AND
      chemistry_nobels.yr IS NULL)
    ORDER BY
      yr
  SQL
end
