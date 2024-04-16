import '../../data/model/trade_marketing_model.dart';

abstract class RepositoryTradeMarketing {
  Future<TradeMarketingEntity?> getTradeMarketing();
  Future<TradeMarketingPageModel?> getFormTradeMarketing();
}