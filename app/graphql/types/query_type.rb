Types::QueryType = GraphQL::ObjectType.define do

  PER_PAGE = 5

  name 'Query'

  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  ##
  # Retrieve all posts
  #
  field :posts do
    type types[Types::PostType]
    argument :page, types.Int
    description 'Find all Posts'
    resolve -> (obj, args, ctx) do
      page = args['page'].to_i <= 1 ? 1 : args['page'].to_i
      offset = PER_PAGE * (page - 1)

      Post.all.offset(offset).limit(PER_PAGE)
    end
  end

  ##
  # Retrieve a specific post
  #
  field :post do
    type Types::PostType
    argument :id, !types.ID
    description 'Find a post by ID'
    resolve -> (obj, args, ctx) { Post.find(args['id']) }
  end
end
