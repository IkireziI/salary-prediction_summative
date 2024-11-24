from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import pandas as pd
import joblib
import numpy as np
import uvicorn

# Initialize FastAPI app
app = FastAPI(
    title="Salary Prediction API",
    description="Predict salaries based on employee features",
    version="1.0"
)

# Load the trained model and preprocessing artifacts
try:
    model = joblib.load("model/decision_tree_model.joblib")
    scaler = joblib.load("model/scaler.joblib")
    label_encoder = joblib.load("model/label_encoder.joblib")
    trained_columns = joblib.load("model/trained_columns.joblib")
except Exception as e:
    raise RuntimeError(f"Error loading model or preprocessing files: {str(e)}")

# Request schema
class EmployeeData(BaseModel):
    age: float
    years_of_experience: float
    gender: str
    education_level: str
    job_title: str

# Utility function to preprocess input data
def preprocess_input(data: pd.DataFrame) -> pd.DataFrame:
    try:
        # Encode gender
        data['Gender'] = label_encoder.transform(data['Gender'])

        # Standardize numeric columns
        data[['Age', 'Years of Experience']] = scaler.transform(data[['Age', 'Years of Experience']])

        # One-hot encode categorical features
        data = pd.get_dummies(data, columns=['Education Level', 'Job Title'], drop_first=False)

        # Ensure input columns match trained model
        for col in trained_columns:
            if col not in data.columns:
                data[col] = 0
        data = data[trained_columns]
        return data
    except Exception as e:
        raise ValueError(f"Error in preprocessing: {str(e)}")

# Endpoint for health check
@app.get("/")
def read_root():
    return {"message": "Welcome to the Salary Prediction API"}

# Prediction endpoint
@app.post("/predict/")
def predict_salary(employee: EmployeeData):
    try:
        # Convert input data to DataFrame
        input_data = pd.DataFrame([{
            "Age": employee.age,
            "Years of Experience": employee.years_of_experience,
            "Gender": employee.gender,
            "Education Level": employee.education_level,
            "Job Title": employee.job_title
        }])

        # Preprocess the input data
        processed_data = preprocess_input(input_data)

        # Predict salary
        salary_prediction = model.predict(processed_data)
        return {"predicted_salary": round(float(salary_prediction[0]), 2)}
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error in prediction: {str(e)}")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust this to restrict allowed origins in production
    allow_credentials=True,
    allow_methods=["*"],  # Adjust to restrict allowed HTTP methods if needed
    allow_headers=["*"],  # Adjust to restrict allowed headers if needed
)

# Main entry point
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000, reload=True)
