# myapp/management/commands/import_data.py

import json
from django.core.management.base import BaseCommand
from main.models import Subject, Topic

class Command(BaseCommand):
    help = 'Import subjects and topics from JSON file'

    def add_arguments(self, parser):
        parser.add_argument('json_file', type=str)

    def handle(self, *args, **options):
        # Open and load data from the JSON file
        with open(options['json_file'], 'r') as file:
            data = json.load(file)

        # Iterate over each subject in the data
        for subject_data in data['subjects']:
            # Create or get the subject object
            subject, created = Subject.objects.get_or_create(
                name=subject_data['name'],
                defaults={'description': subject_data.get('description', '')}
            )

            # Iterate over each topic related to the current subject
            for topic_data in subject_data['topics']:
                # Create or get the topic object associated with the subject
                Topic.objects.get_or_create(
                    subject=subject,
                    name=topic_data['name'],
                    defaults={'description': topic_data.get('description', '')}
                )

        # Print a success message after importing data
        self.stdout.write(self.style.SUCCESS('Successfully imported data'))
