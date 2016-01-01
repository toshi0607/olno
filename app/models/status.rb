class Status < ActiveRecord::Base

  # user_id毎の最新レコード
  scope :latest_by_user, -> {
    sub_query = <<-SQL
      SELECT user_id,
        MAX(CASE WHEN logged_out_at IS NULL THEN logged_in_at ELSE logged_out_at END) AS max_datetime
      FROM statuses
      GROUP BY user_id
    SQL

    join_sql = <<-SQL
      INNER JOIN (#{sub_query}) AS sub
        ON sub.user_id = statuses.user_id
        AND sub.max_datetime = CASE WHEN statuses.logged_out_at IS NULL THEN statuses.logged_in_at ELSE statuses.logged_out_at END
    SQL

    joins(join_sql)
  }

  # 入室中なら真。さもなくば偽。
  def inside?
    logged_out_at.nil?
  end

  # 滞在時間
  def length_of_stay
    end_at = try(:logged_out_at) || Time.current
    end_at - logged_in_at
  end
end
