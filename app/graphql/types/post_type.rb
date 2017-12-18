Types::PostType = GraphQL::ObjectType.define do
  name 'Post'

  field :id, !types.ID
  field :title, !types.String
  field :body, !types.String
  field :rating, types.Int
  field :created_at, !types.String
  field :comments, types[!Types::CommentType] do
    resolve -> (record, args, ctx) {
      Loaders::RecordLoader.for(Comment).load(record.id)
    }
  end
end
