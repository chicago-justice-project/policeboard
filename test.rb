require 'aws-sdk'

s3 = Aws::S3::Client.new(
 access_key_id: 'AKIAJR7T4PRN3TPSFXPQ',
 secret_access_key: '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',
 region: 'us-west-2')

puts s3.list_buckets
