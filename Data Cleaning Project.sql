
----

SELECT  SaleDate from National_housing

ALTER TABLE National_housing
Add SaleDateCoverted Date;
update National_housing
set SaleDateCoverted = Convert(Date, SaleDate)

SELECT SaleDateCoverted from National_housing
ALTER TABLE National_housing
  Alter Column SaleDateCoverted Date 

  ----populate property address date
  Select *
  from National_housing
  where PropertyAddress is null
  
  select  a.ParcelID, b.ParcelID,a.PropertyAddress, b.PropertyAddress , ISNULL (a.PropertyAddress,b.PropertyAddress)
  from National_housing a
  Join National_housing b
  on a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null


  Update a 
  SET PropertyAddress = ISNULL (a.PropertyAddress,b.PropertyAddress)
  from National_housing a
  Join National_housing b
  on a.ParcelID = b.ParcelID
  AND a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null

  --------------------------------------------------------------------------
   ---Breaking out Property Address into Individual columns (Address, City, State)

   select PropertyAddress
   from National_housing

   Select
   SUBSTRING(PropertyAddress,1, CHARINDEX (',', PropertyAddress) -1 ) as Address
   , SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address
from National_housing 

ALTER TABLE National_housing
ADD PropertySplitAddress nVarChar(255)

Update National_housing
set PropertySplitAddress = SUBSTRING(PropertyAddress,1, CHARINDEX (',', PropertyAddress) -1 )

Alter Table National_housing
ADD PropertySplitCity nVarChar(255)

update National_housing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))


select *
from National_housing

----Breaking out the OwnerAddress using the function PARSENAME. Now, the PARSENAME function works only if the delimeter is a full stop(.), so I replace the comma in the OwnerAddress with a full stop.


Select OwnerAddress
from National_housing


SELECT 
PARSENAME(Replace(OwnerAddress,',','.'), 3),
PARSENAME(Replace(OwnerAddress,',','.'), 2),
PARSENAME(Replace(OwnerAddress,',','.'), 1)
from National_housing



Alter Table National_housing
ADD OwnerSplitAddress nVarChar (225)

update National_housing
set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress,',','.'), 3)

Alter Table National_housing
Add OwnerSplitCity nVarChar (255)

update National_housing
set OwnerSplitCity = PARSENAME(Replace(OwnerAddress,',','.'), 2)

Alter Table National_housing
Add OwnerSplitState nVarChar (225)

Update National_housing
Set OwnerSplitState = PARSENAME(Replace(OwnerAddress,',','.'),1)

select*
from National_housing

---Changing 'Y' and 'N' to 'Yes' and 'No' in the SoldAsVacant Column

Select Distinct(SoldAsVacant)
from National_housing

Select
 CASE When SoldAsVacant = 'Y' Then 'Yes'
 When SoldAsVacant = 'N' Then 'No'
 Else SoldAsVacant
 End
 from National_housing

 Update National_housing
 Set SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
 When SoldAsVacant = 'N' Then 'No'
 Else SoldAsVacant
 End
 Select Distinct(SoldAsVacant)
from National_housing

--Deleting Unused columns

Alter Table National_housing
Drop Column OwnerAddress,PropertyAddress,SaleDate, TaxDistrict

select *
from National_housing