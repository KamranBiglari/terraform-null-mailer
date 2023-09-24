COPY library-scripts/terraform-debian.sh /tmp/library-scripts/
RUN apt-get update && bash /tmp/library-scripts/terraform-debian.sh