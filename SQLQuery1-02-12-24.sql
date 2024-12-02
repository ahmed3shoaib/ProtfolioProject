SELECT OwnerAddress FROM NashvilleHousing


SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
From NashvilleHousing


-----------------------------------------------------------------------------------------------------------------
SELECT a.ParcelID,a.OwnerAddress,b.ParcelID,b.OwnerAddress FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.OwnerAddress is Null

UPDATE a
SET OwnerAddress = ISNULL(a.OwnerAddress,b.OwnerAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.OwnerAddress is Null

SELECT  OwnerAddress FROM NashvilleHousing
WHERE OwnerAddress IS  NULL


ALTER TABLE Nashvillehousing
ADD OwnerSplitAddres Nvarchar(255)

ALTER TABLE NashvilleHousing
Add OwnerCityAddress nvarchar(255)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255)

UPDATE NashvilleHousing
SET OwnerSplitAddres = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

UPDATE NashvilleHousing
SET OwnerCityAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)



SELECT * FROM NashvilleHousing


----------------------------------------------------------------------------------------------
--Change "Y"and "N " to YES AND NO in Field :"SoldasVaccant"


SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant) FROM NashvilleHousing
GROUP BY SoldAsVacant
Order BY 2


SELECT  SoldAsVacant,
CASE WHEN SoldAsVacant ='Y' THEN 'YES'
     WHEN SoldAsVacant= 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant ='Y' THEN 'YES'
     WHEN SoldAsVacant= 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END
-------------------------------------------------------------------------------------------------------------------------
--Remove Duplicates
WITH RowNumCTE AS(
SELECT * ,
      ROW_NUMBER() OVER(
	  PARTITION BY ParcelID,
	  PropertyAddress,
	  SaleDate,
	  SalePrice,
	  LegalReference
	  Order By
	  UniqueID
	  ) row_no

From NashvilleHousing

)
SELECT *  FROM 
RowNumCTE
WHERE row_no >1
ORDER BY PropertyAddress

-------------------------------------------------------------------------------------------------------
-- DELET Unused Colum

SELECT * FROM NashvilleHousing

ALTER TABLE NashvilleHousing
	 DROP COLUMN PropertyAddress,TaxDistrict,OwnerAddress









SELECT * FROM NashvilleHousing
