--Superheavy Samurai Kokorogamae
function c13790621.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c13790621.sumcon)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(98777036,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_HAND)
	e3:SetCode(EVENT_DAMAGE)
	e3:SetCondition(c13790621.sumcon1)
	e3:SetTarget(c13790621.sumtg)
	e3:SetOperation(c13790621.sumop)
	c:RegisterEffect(e3)
end
function c13790621.sfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c13790621.sumcon(e)
	return Duel.IsExistingMatchingCard(c13790621.sfilter,e:GetHandlerPlayer(),LOCATION_GRAVE,0,1,nil)
end

function c13790621.sumcon1(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and ep==tp
end
function c13790621.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if Duel.IsExistingMatchingCard(c13790621.sfilter,tp,LOCATION_GRAVE,0,1,nil) then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c13790621.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e2)
	end
end
