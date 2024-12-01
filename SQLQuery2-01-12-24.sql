/*
Cleaning Data in SQL Queries

*/

SELECT * FROM NashvilleHousing



----------------------------------------------------------------------------

-- Standardize Date Formate

SELECT SaleDate,CONVERT(Date,SaleDate) AS SaleDate FROM NashvilleHousing

Update NashvilleHousing 
Set SaleDate=CONVERT(Date,SaleDate)

SELECT SaleDate From NashvilleHousing

Alter Table NashvilleHousing
ADD SaleDateConverted Date;




SELECT * FROM NashvilleHousing

SELECT SaleDate ,   CAST(SaleDate AS Date) as SaleDateConverted FROM NashvilleHousing

---------------------------------------------------------------------------------------

-- Populate Property Address

SELECT * FROM NashvilleHousing
--Where PropertyAddress is Null
ORDER BY ParcelID

SELECT a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is Null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is Null

SELECT PropertyAddress FROM NashvilleHousing
Where PropertyAddress Is Null

----------------------------------------------------------------------------------------

-- Breaking Out Address Into Indivisual Colums (Address,City,Sate)

SELECT PropertyAddress FROM NashvilleHousing
--Order By ParcelID

SELECT 
SUBSTRING(PropertyAddress,1 ,CHARINDEX(',', PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, Len(PropertyAddress)) as Address

FROM NashvilleHousing



ALTER TABLE Nashvillehousing
ADD PropertySplitAddress Nvarchar(255)

ALTER TABLE NashvilleHousing
Add PropertyCityAddress nvarchar(255)

SELECT * FROM NashvilleHousing

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,1 ,CHARINDEX(',', PropertyAddress)-1)

UPDATE NashvilleHousing
SET PropertyCityAddress= SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress) +1, Len(PropertyAddress))

