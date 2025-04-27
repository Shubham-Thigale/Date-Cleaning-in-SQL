Select * 
from [Portfolio Project].dbo.NashVilleHousing

--Standardize data format

Select SaleDateConverted, CONVERT(Date, SaleDate)
from [Portfolio Project].dbo.NashVilleHousing

Update NashVilleHousing
SET  SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashVilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

--Populating Property Address Data

Select *
from [Portfolio Project].dbo.NashVilleHousing
--where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project].dbo.NashVilleHousing a
JOIN [Portfolio Project].dbo.NashVilleHousing b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from [Portfolio Project].dbo.NashVilleHousing a
JOIN [Portfolio Project].dbo.NashVilleHousing b
on a.ParcelID=b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


--Breaking out address into individual columns (address,city,state)

Select PropertyAddress
from [Portfolio Project].dbo.NashVilleHousing
--where PropertyAddress is null
--order by ParcelID

SELECT

SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1, LEN(PropertyAddress)) as Address   -- +1 to remove the comma in new col

from [Portfolio Project].dbo.NashVilleHousing


ALTER TABLE NashVilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashVilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity nvarchar(255);

Update NashVilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) + 1, LEN(PropertyAddress))

Select * 
from [Portfolio Project].dbo.NashVilleHousing



Select OwnerAddress
from [Portfolio Project].dbo.NashVilleHousing

select
PARSENAME(Replace(OwnerAddress,',','.'),3)
,PARSENAME(Replace(OwnerAddress,',','.'),2)
,PARSENAME(Replace(OwnerAddress,',','.'),1)
from [Portfolio Project].dbo.NashVilleHousing

ALTER TABLE NashVilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashVilleHousing
SET OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity nvarchar(255);

Update NashVilleHousing
SET OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState nvarchar(255);

Update NashVilleHousing
SET OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),2)

Select *
from [Portfolio Project].dbo.NashVilleHousing

-- Select Y and N to Yes and No in "SoldAsVacant" field

Select distinct(SoldAsVacant), Count(SoldAsVacant)
from [Portfolio Project].dbo.NashVilleHousing
group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant='Y' Then 'Yes'
		When SoldAsVacant='N' Then 'No'
		Else SoldAsVacant
		End
from [Portfolio Project].dbo.NashVilleHousing

Update NashVilleHousing
SET SoldAsVacant= CASE When SoldAsVacant='Y' Then 'Yes'
		When SoldAsVacant='N' Then 'No'
		Else SoldAsVacant
		End

--Removes Duplicates

WITH RowNumCTE AS(
Select * ,
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				ORDER BY
					UniqueID
					)row_num
from [Portfolio Project].dbo.NashVilleHousing
--order by ParcelID
)
Delete
From RowNumCTE

where row_num > 1
--order by PropertyAddress



--- Delete Unused Columns

Select * 
from [Portfolio Project].dbo.NashVilleHousing

ALTER TABLE [Portfolio Project].dbo.NashVilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

ALTER TABLE [Portfolio Project].dbo.NashVilleHousing
DROP COLUMN SaleDate

Select * 
from [Portfolio Project].dbo.NashVilleHousing