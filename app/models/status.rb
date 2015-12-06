class Status < ActiveRecord::Base

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
