class RakingRound < ActiveRecord::Base
  belongs_to :planned_raking_list
  belongs_to :school_year
  has_many :planned_raking_entries, dependent: :destroy

  validates_presence_of :planned_raking_list, :school_year, :number

  def already_rekt_count
    return ActiveRecord::Base.connection.execute("SELECT COUNT(*) FROM(SELECT DISTINCT ON (planned_raking_entries.class_member_id) * FROM planned_raking_entries WHERE(planned_raking_entries.raking_round_id = #{id})) AS penis").values[0][0].to_i
  end

  def not_rekt_yet_count
    return planned_raking_list.sclass.class_members.count - already_rekt_count
  end

  def not_rekt_yet_query
    return planned_raking_list.sclass.class_members.where("id NOT IN (:list_ids)", list_ids: planned_raking_entries.select("DISTINCT ON(planned_raking_entries.class_member_id) planned_raking_entries.class_member_id").map(&:class_member_id)).order(:last_name)
  end
end
