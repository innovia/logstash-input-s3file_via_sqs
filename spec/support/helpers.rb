# encoding: utf-8

def fetch_events(config, local_filename, s3_file_info)
  queue = []
  s3 = LogStash::Inputs::S3FileViaSqs.new(settings)
  s3.register
  s3.process_local_log(queue, local_filename, s3_file_info)
  queue
end



def push_sqs_event(message)
  client = Aws::SQS::Client.new
  queue_url = client.get_queue_url(:queue_name => ENV["SQS_QUEUE_NAME"])

  client.send_message({
    queue_url: queue_url.queue_url,
    message_body: message,
  })
end