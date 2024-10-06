import http.server
import os
import sys
from urllib.parse import urlparse, unquote

class ASPHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # Log the requested path for debugging
        print(f"Original Requested Path: {self.path}")

        # Parse the URL and remove the query string
        parsed_url = urlparse(self.path)
        clean_path = unquote(parsed_url.path)  # Remove query string and URL encode

        print(f"Cleaned Path (without query): {clean_path}")

        # Check if the requested file ends with ".asp"
        if clean_path.endswith(".asp"):
            # Construct the file path based on the provided directory and cleaned path
            requested_file = clean_path.lstrip('/')
            file_path = os.path.join(self.server.base_directory, requested_file)

            print(f"Serving File: {file_path}")  # Log the full file path for debugging

            # Check if the file exists and serve it
            if os.path.isfile(file_path):
                try:
                    # Open the .asp file and read its content
                    with open(file_path, 'r') as f:
                        content = f.read()

                    # Escape ASP tags to display as text
                    content = content.replace('<%', '').replace('%>', '')

                    # Serve the modified content as HTML
                    self.send_response(200)
                    self.send_header('Content-type', 'text/html')  # Set content type to HTML
                    self.end_headers()
                    self.wfile.write(content.encode('utf-8'))

                except Exception as e:
                    # Log the error and return a 500 error
                    print(f"Error reading file: {e}")
                    self.send_error(500, "Internal Server Error")
            else:
                # Log that the file was not found and return a 404 error
                print(f"File not found: {file_path}")
                self.send_error(404, "File not found")
        else:
            # For other file types, serve them normally
            super().do_GET()

if __name__ == '__main__':
    # Check if a directory argument was provided
    if len(sys.argv) < 2:
        print("Usage: python3 serve_asp.py <directory>")
        sys.exit(1)

    # Get the directory from the argument
    directory = sys.argv[1]
    if not os.path.isdir(directory):
        print(f"Error: The directory '{directory}' does not exist.")
        sys.exit(1)

    # Set up the server to serve from the provided directory
    server_address = ('', 8000)  # Listen on port 8000
    handler_class = ASPHandler
    handler_class.directory = directory  # Set the directory for the handler

    # Create and start the server
    httpd = http.server.HTTPServer(server_address, handler_class)
    httpd.base_directory = directory  # Set the base directory for the server
    print(f"Serving files from {directory} on port 8000...")
    httpd.serve_forever()
