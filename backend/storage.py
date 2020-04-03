from google.cloud import storage

def upload_blob(bucket_name, data, destination_blob_name):
    """Uploads a file to the bucket.
    Args:
        bucket_name: "your-bucket-name"
        destination_blob_name: "storage-object-name"
        data: string
    """

    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_string(data)


def download_blob(bucket_name, source_blob_name):
    """Downloads a blob from the bucket.
    Args:
        bucket_name: "your-bucket-name"
        source_blob_name: "storage-object-name"
    """
    storage_client = storage.Client()

    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    return blob.download_as_string().decode()

def check_if_exists(bucket_name, source_blob_name):
    storage_client = storage.Client()

    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(source_blob_name)
    return  blob.exists()