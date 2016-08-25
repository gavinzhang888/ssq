# Disable for all serializers (except ArraySerializer)
ActiveModel::Serializer.root = "body"

# Disable for ArraySerializer
ActiveModel::ArraySerializer.root = "body"
