--暗黒の召喚神
function c100000069.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000069,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c100000069.cost)
	e1:SetTarget(c100000069.target)
	e1:SetOperation(c100000069.operation)
	c:RegisterEffect(e1)	
end
function c100000069.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() and Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	Duel.Release(e:GetHandler(),REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c100000069.spfilter(c,e,tp,code)
	return c:IsCode(code) 
	and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c100000069.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2
		and Duel.IsExistingTarget(c100000069.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,32491822)
		and Duel.IsExistingTarget(c100000069.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,69890967)
		and Duel.IsExistingTarget(c100000069.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,6007213) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c100000069.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,32491822)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c100000069.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,69890967)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g3=Duel.SelectTarget(tp,c100000069.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,6007213)
	g1:Merge(g2)
	g1:Merge(g3)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,3,0,0)
end
function c100000069.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 then return end
	Duel.SpecialSummon(g,0,tp,tp,true,true,POS_FACEUP)
end