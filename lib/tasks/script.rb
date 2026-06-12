require 'net/http'
require 'json'

url = URI('https://dummyjson.com/products?limit=200')
response = Net::HTTP.get(url)

products = JSON.parse(response)['products']

products.each do |item|
  puts "Importing #{item['title']}..."

  category = Category.find_or_create_by!(
    name: item['category'].titleize,
    slug: item['category'].parameterize
  )

  product = Product.find_or_initialize_by(
    sku: item['sku']
  )

  product.assign_attributes(
    title: item['title'],
    description: item['description'],
    price: item['price'],
    discount_percentage: item['discountPercentage'],
    inventory_count: item['stock'],
    brand: item['brand'],
    weight: item['weight'],
    thumbnail: item['thumbnail'],
    availability_status: item['availabilityStatus'],
    category: category
  )

  product.save!


  # Dimensions
  if item['dimensions'].present?
    dimension = product.product_dimension || product.build_product_dimension

    dimension.update!(
      width: item['dimensions']['width'],
      height: item['dimensions']['height'],
      depth: item['dimensions']['depth']
    )
  end

  # Tags
  item['tags'].each do |tag_name|
    tag = Tag.find_or_create_by!(name: tag_name)

    ProductTag.find_or_create_by!(
      product: product,
      tag: tag
    )
  end

  # Images
  item['images'].each do |image_url|
    ProductImage.find_or_create_by!(
      product: product,
      image_url: image_url
    )
  end

  # Reviews
  item['reviews'].each do |review_data|
    Review.find_or_create_by!(
      product: product,
      reviewer_email: review_data['reviewerEmail'],
      comment: review_data['comment']
    ) do |review|
      review.rating = review_data['rating']
      review.reviewer_name = review_data['reviewerName']
      review.reviewed_at = review_data['date']
    end
  end
end

puts "Import complete!"