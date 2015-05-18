--Odd-Eyes Fusion
function c13720108.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,13720108+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c13720108.target)
	e1:SetOperation(c13720108.activate)
	c:RegisterEffect(e1)
end
function c13720108.filter0(c)
	return c:IsCanBeFusionMaterial() and c:IsAbleToGrave() and c:IsSetCard(0x99)
end
function c13720108.filter1(c,e)
	return c:IsCanBeFusionMaterial() and c:IsAbleToGrave() and c:IsSetCard(0x99) and not c:IsImmuneToEffect(e)
end
function c13720108.filter2(c,e,tp,m,f,chkf)
	return c:IsType(TYPE_FUSION) and c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_FUSION,tp,false,false) 
	and c:CheckFusionMaterial(m,nil,chkf)
end
function c13720108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local mg1=Duel.GetMatchingGroup(c13720108.filter0,tp,LOCATION_HAND+LOCATION_MZONE,0,nil)
		if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 then
			local sg=Duel.GetMatchingGroup(c13720108.filter0,tp,LOCATION_EXTRA,0,nil)
			mg1:Merge(sg)
		end
		local res=Duel.IsExistingMatchingCard(c13720108.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg1,nil,chkf)
		if not res then
			local ce=Duel.GetChainMaterial(tp)
			if ce~=nil then
				local fgroup=ce:GetTarget()
				local mg2=fgroup(ce,e,tp)
				local mf=ce:GetValue()
				res=Duel.IsExistingMatchingCard(c13720108.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg2,mf,chkf)
			end
		end
		return res
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c13720108.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	local mg1=Duel.GetMatchingGroup(c13720108.filter1,tp,LOCATION_HAND+LOCATION_MZONE,0,nil,e)
	if Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and	Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>1
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 then
		local sg=Duel.GetMatchingGroup(c13720108.filter1,tp,LOCATION_EXTRA,0,nil,e)
		mg1:Merge(sg)
	end
	local sg1=Duel.GetMatchingGroup(c13720108.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg1,nil,chkf)
	local mg2=nil
	local sg2=nil
	local ce=Duel.GetChainMaterial(tp)
	if ce~=nil then
		local fgroup=ce:GetTarget()
		mg2=fgroup(ce,e,tp)
		local mf=ce:GetValue()
		sg2=Duel.GetMatchingGroup(c13720108.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg2,mf,chkf)
	end
	if sg1:GetCount()>0 or (sg2~=nil and sg2:GetCount()>0) then
		local sg=sg1:Clone()
		if sg2 then sg:Merge(sg2) end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		if sg1:IsContains(tc) and (sg2==nil or not sg2:IsContains(tc) or not Duel.SelectYesNo(tp,ce:GetDescription())) then
			local mat1=Duel.SelectFusionMaterial(tp,tc,mg1,nil,chkf)
			tc:SetMaterial(mat1)
			Duel.SendtoGrave(mat1,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,SUMMON_TYPE_FUSION,tp,tp,false,false,POS_FACEUP)
		else
			local mat2=Duel.SelectFusionMaterial(tp,tc,mg2,nil,chkf)
			local fop=ce:GetOperation()
			fop(ce,e,tp,tc,mat2)
		end
		tc:CompleteProcedure()
	else
		local cg1=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_MZONE,0)
		local cg2=Duel.GetFieldGroup(tp,LOCATION_EXTRA,0)
		if cg1:GetCount()>1 and cg2:IsExists(Card.IsFacedown,1,nil)
			and Duel.IsPlayerCanSpecialSummon(tp) and not Duel.IsPlayerAffectedByEffect(tp,27581098) then
			Duel.ConfirmCards(1-tp,cg1)
			Duel.ConfirmCards(1-tp,cg2)
			Duel.ShuffleHand(tp)
		end
	end
end