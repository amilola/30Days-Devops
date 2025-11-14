#using lightweight python image
FROM python:3.10-slim

#set working directory 
WORKDIR /app

#Copy Dependencies first
COPY requirements.txt .

#Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

#copy the rest of the application
COPY . .

#Expose port 5000 for the app
EXPOSE 5000

#Command to run the app
CMD ["python", "app.py"]