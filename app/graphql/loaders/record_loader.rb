class Loaders::RecordLoader < GraphQL::Batch::Loader
  def initialize(clazz)
    @clazz = clazz
  end

  def perform(post_ids)
    @clazz.where(post_id: post_ids)
      .group_by(&:post_id)
      .each { |post_id, records| fulfill(post_id, records) }

    post_ids.each { |id| fulfill(id, []) unless fulfilled?(id) }
  end
end
